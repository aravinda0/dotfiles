# Default config:
#   https://github.com/prompt-toolkit/ptpython/blob/master/examples/ptpython_config/config.py
# prompt-toolkit defaults;
#   https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/src/prompt_toolkit/key_binding/bindings/basic.py
#   https://github.com/prompt-toolkit/python-prompt-toolkit/blob/master/src/prompt_toolkit/key_binding/bindings/named_commands.py
# --------------------------------------------------------------------------------

from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.key_processor import KeyPress
from prompt_toolkit.key_binding.bindings.named_commands import get_by_name
from prompt_toolkit.keys import Keys


def configure(repl):
    repl.vi_mode = True

    repl.color_depth = "DEPTH_24_BIT"
    repl.use_code_colorscheme("native")

    repl.enable_history_search = True
    repl.complete_while_typing = True

    @repl.add_key_binding("j", "k", filter=ViInsertMode())
    def _(event):
        event.cli.key_processor.feed(KeyPress(Keys("escape")))

    repl.add_key_binding("c-k", filter=ViInsertMode())(get_by_name("previous-history"))
    repl.add_key_binding("c-j", filter=ViInsertMode())(get_by_name("next-history"))
