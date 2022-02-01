# Default config:
#   https://github.com/prompt-toolkit/ptpython/blob/master/examples/ptpython_config/config.py
# --------------------------------------------------------------------------------

from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.key_processor import KeyPress
from prompt_toolkit.keys import Keys


def configure(repl):
    repl.vi_mode = True

    repl.color_depth = "DEPTH_24_BIT"
    repl.use_code_colorscheme("native")

    @repl.add_key_binding("j", "k", filter=ViInsertMode())
    def _(event):
        event.cli.key_processor.feed(KeyPress(Keys("escape")))
