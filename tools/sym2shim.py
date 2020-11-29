import re
import argparse

SYM_RE = re.compile(r'([0-9a-fA-F]{2}):([0-9a-fA-F]{4})\s(\w+[^\.])$')

if __name__ == '__main__':
	ap = argparse.ArgumentParser()
	ap.add_argument('input', type=argparse.FileType('r'))
	ap.add_argument('output', type=argparse.FileType('w'))
	args = ap.parse_args()
	line = args.input.readline()
	
	while(line):
		nl = re.match(SYM_RE, line)
		if nl is not None:
			nl_g = nl.groups()
			if nl_g[0] != '00':
				args.output.write('\nBANK_{} equ ${}\n{} equ ${}\n'.format(
					nl_g[2].replace('\n',''),
					nl_g[0],
					nl_g[2].replace('\n',''),
					nl_g[1],
					)
				)
			else:
				args.output.write('{} equ ${}\n'.format(
					nl_g[2].replace('\n',''),
					nl_g[1]
					)
				)
		line = args.input.readline()
