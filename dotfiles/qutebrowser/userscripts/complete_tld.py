#! /usr/bin/env python

from qute import qutescript, Qute


@qutescript
def main(qute: Qute):
    open_cmd, *frags = qute.commandline_text.split(" ")
    if open_cmd != ":open":
        return

    args, flags = [], []
    for arg in frags:
        if arg.startswith("-"):
            flags.append(arg)
        else:
            args.append(arg)

    if len(args) != 1:
        return

    tld = ".com"
    modified_cmd = f"open {' '.join(flags)} https://{args[0]}{tld};; mode-leave"

    qute.send(modified_cmd)


if __name__ == "__main__":
    main()
