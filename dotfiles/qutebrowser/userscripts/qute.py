import os


class Qute:
    """A simple helper to interact with the userscript environment provided by
    qutebrowser and send commands to the browser.

    Docs:
        - qute://help/userscripts.html
    """

    def __init__(self):
        self.fifo: str = self._parse_fifo()

        self.mode: str = os.getenv("QUTE_MODE", "")
        self.commandline_text: str = os.getenv("QUTE_COMMANDLINE_TEXT", "")
        self.html_file_path: str = os.getenv("QUTE_HTML", "")
        self.text_file_path: str = os.getenv("QUTE_TEXT", "")
        self.user_agent: str = os.getenv("QUTE_USER_AGENT", "")
        self.config_dir: str = os.getenv("QUTE_CONFIG_DIR", "")
        self.data_dir: str = os.getenv("QUTE_DATA_DIR", "")
        self.download_dir: str = os.getenv("QUTE_DOWNLOAD_DIR", "")

        self.url: str = os.getenv("QUTE_URL", "")
        self.tab_index: str = os.getenv("QUTE_TAB_INDEX", "")
        self.title: str = os.getenv("QUTE_TITLE", "")
        self.selected_text: str = os.getenv("QUTE_SELECTED_TEXT", "")
        self.count: str = os.getenv("QUTE_COUNT", "")

        self.selected_html: str = os.getenv("QUTE_SELECTED_HTML", "")

    def send(self, command: str):
        with open(self.fifo, "w") as pipe:
            pipe.write(command)

    def _parse_fifo(self) -> str:
        fifo = os.getenv("QUTE_FIFO")
        if fifo is None:
            raise EnvironmentError(
                "Could not find QUTE_FIFO in environment variables. Was this "
                "script invoked correctly?"
            )
        return fifo


def qutescript(func):
    """Wrap a userscript function with this to have a `Qute` instance be passed in as an
    argument.

    Example:

        @qutescript
        def my_userscript(qute):
            qute.send("scroll down")
    """

    def _inner():
        qute = Qute()
        return func(qute)

    return _inner
