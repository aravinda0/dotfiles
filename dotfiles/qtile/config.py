import os
import subprocess

from libqtile import bar, hook, layout, widget
from libqtile.config import (
    Click,
    Drag,
    DropDown,
    EzKey,
    KeyChord,
    Match,
    ScratchPad,
    Screen,
)
from libqtile.lazy import lazy
from qtile_bonsai.layout import Bonsai

from workspaces import (
    activate_context,
    activate_group_set,
    activate_standard_group,
    cycle_group_in_group_set,
    make_groups_from_contexts,
)
import utils


# TODO: Figure out how to not hardcode this. zsh env var not set yet when qtile runs.
DOTFILES_PATH = os.path.expanduser("~/.dotfiles")


terminal = "alacritty"


def _activate_context(context):
    @lazy.function
    def inner(_):
        activate_context(context)

    return inner


def _activate_group_set(group_set):
    @lazy.function
    def inner(_):
        activate_group_set(group_set)

    return inner


def _activate_standard_group(standard_group):
    @lazy.function
    def inner(_):
        activate_standard_group(standard_group)

    return inner


def _cycle_group_in_group_set(step=1):
    @lazy.function
    def inner(_):
        cycle_group_in_group_set(step)

    return inner


def resize(qtile, direction):
    layout = qtile.current_layout
    child = layout.current
    parent = child.parent

    # Not using layout.grow_amount since seems too much
    grow_amount = 2

    while parent:
        if child in parent.children:
            layout_all = False

            if (direction == "left" and parent.split_horizontal) or (
                direction == "up" and not parent.split_horizontal
            ):
                parent.split_ratio = max(5, parent.split_ratio - grow_amount)
                layout_all = True
            elif (direction == "right" and parent.split_horizontal) or (
                direction == "down" and not parent.split_horizontal
            ):
                parent.split_ratio = min(95, parent.split_ratio + grow_amount)
                layout_all = True

            if layout_all:
                layout.group.layout_all()
                break

        child = parent
        parent = child.parent


@lazy.function
def resize_left(qtile):
    resize(qtile, "left")


@lazy.function
def resize_right(qtile):
    resize(qtile, "right")


@lazy.function
def resize_up(qtile):
    resize(qtile, "up")


@lazy.function
def resize_down(qtile):
    resize(qtile, "down")


# keycodes: https://github.com/qtile/qtile/blob/master/libqtile/backend/x11/xkeysyms.py
keys = [
    # --------------------------------------------------------------------------------
    # qtile-bonsai
    # --------------------------------------------------------------------------------
    EzKey("M-v", lazy.layout.spawn_split(terminal, "x")),
    EzKey("M-x", lazy.layout.spawn_split(terminal, "y")),
    EzKey("M-n", lazy.layout.spawn_tab(terminal)),
    EzKey("M-S-n", lazy.layout.spawn_tab(terminal, new_level=True)),
    EzKey("M-t", lazy.layout.spawn_tab(terminal)),
    EzKey("M-S-t", lazy.layout.spawn_tab(terminal, new_level=True)),
    EzKey("M-h", lazy.layout.left()),
    EzKey("M-l", lazy.layout.right()),
    EzKey("M-k", lazy.layout.up()),
    EzKey("M-j", lazy.layout.down()),
    EzKey("M-C-h", lazy.layout.resize_left(100)),
    EzKey("M-C-l", lazy.layout.resize_right(100)),
    EzKey("M-C-k", lazy.layout.resize_up(100)),
    EzKey("M-C-j", lazy.layout.resize_down(100)),
    EzKey("A-d", lazy.layout.prev_tab()),
    EzKey("A-f", lazy.layout.next_tab()),
    EzKey("C-S-r", lazy.layout.rename_tab()),
    EzKey("M-S-h", lazy.layout.swap_left()),
    EzKey("M-S-l", lazy.layout.swap_right()),
    EzKey("M-S-k", lazy.layout.swap_up()),
    EzKey("M-S-j", lazy.layout.swap_down()),
    EzKey("A-S-d", lazy.layout.swap_prev_tab()),
    EzKey("A-S-f", lazy.layout.swap_next_tab()),
    # --------------------------------------------------------------------------------
    # --------------------------------------------------------------------------------
    # Groups organization
    # --------------------------------------------------------------------------------
    EzKey("M-C-1", _activate_context("work")),
    EzKey("M-C-2", _activate_context("study: topic1")),
    EzKey("M-C-3", _activate_context("study: topic2")),
    EzKey("M-C-4", _activate_context("study: playground")),
    EzKey("M-C-5", _activate_context("craft")),
    EzKey("M-C-8", _activate_context("study: pkm")),
    EzKey("M-C-9", _activate_context("misc")),
    EzKey("M-d", _activate_group_set("main")),
    EzKey("M-e", _activate_group_set("notes")),
    EzKey("M-s", _activate_group_set("browser")),
    EzKey("M-1", _activate_standard_group("1")),
    EzKey("M-2", _activate_standard_group("2")),
    EzKey("M-3", _activate_standard_group("3")),
    EzKey("M-4", _activate_standard_group("4")),
    EzKey("M-5", _activate_standard_group("5")),
    EzKey("M-6", _activate_standard_group("6")),
    EzKey("M-7", _activate_standard_group("7")),
    EzKey("M-8", _activate_standard_group("8")),
    EzKey("M-9", _activate_standard_group("9")),
    EzKey("C-A-f", _cycle_group_in_group_set(1)),
    EzKey("C-A-d", _cycle_group_in_group_set(-1)),
    # --------------------------------------------------------------------------------
    # Scratchpads
    # --------------------------------------------------------------------------------
    EzKey("M-<backslash>", lazy.group["scratchpad/rough"].dropdown_toggle("term1")),
    EzKey("C-0", lazy.group["scratchpad/notes"].dropdown_toggle("zk")),
    EzKey("C-A-0", lazy.group["scratchpad/notes"].dropdown_toggle("sec__atp")),
    EzKey("C-9", lazy.group["scratchpad/notes"].dropdown_toggle("sec__spp")),
    EzKey("C-A-9", lazy.group["scratchpad/notes"].dropdown_toggle("sec__dry")),
    EzKey("C-8", lazy.group["scratchpad/notes"].dropdown_toggle("areas/workflow")),
    EzKey("C-<backslash>", lazy.group["scratchpad/notes"].dropdown_toggle("tmp")),
    EzKey(
        "C-<BackSpace>",
        lazy.group["scratchpad/notes"].hide_all(),
    ),
    # --------------------------------------------------------------------------------
    # Window actions
    # --------------------------------------------------------------------------------
    # EzKey("M-S-h", lazy.layout.shuffle_left()),
    # EzKey("M-S-l", lazy.layout.shuffle_right()),
    # EzKey("M-S-j", lazy.layout.shuffle_down()),
    # EzKey("M-S-k", lazy.layout.shuffle_up()),
    EzKey("C-S-n", lazy.layout.normalize()),
    EzKey("C-S-f", lazy.window.toggle_floating()),
    EzKey("C-S-<Return>", lazy.window.toggle_fullscreen()),
    EzKey("M-S-<Return>", lazy.layout.toggle_split()),
    EzKey("M-<Tab>", lazy.next_layout()),
    EzKey("M-C-<Left>", resize_left),
    EzKey("M-C-<Right>", resize_right),
    EzKey("M-C-<Down>", resize_down),
    EzKey("M-C-<Up>", resize_up),
    # --------------------------------------------------------------------------------
    # Audio
    # --------------------------------------------------------------------------------
    EzKey("<XF86AudioRaiseVolume>", lazy.spawn("amixer set -q Master 5%+")),
    EzKey("<XF86AudioLowerVolume>", lazy.spawn("amixer set -q Master 5%-")),
    EzKey("<XF86AudioMute>", lazy.spawn("amixer set -q Master toggle")),
    # --------------------------------------------------------------------------------
    # Misc
    # --------------------------------------------------------------------------------
    EzKey("M-<Return>", lazy.spawn(terminal)),
    EzKey("M-r", lazy.spawncmd()),
    EzKey("M-p", lazy.spawn("rofi -show drun")),
    KeyChord(
        ["mod4"],
        "a",
        [
            EzKey("w", lazy.spawn("qutebrowser")),
            EzKey("q", lazy.spawn("qutebrowser")),
            EzKey("f", lazy.spawn("firefox-developer-edition")),
            EzKey("t", lazy.spawn("qbittorrent")),
        ],
    ),
    EzKey("M-<BackSpace>", lazy.window.kill()),
    EzKey("C-q", lazy.window.kill()),
    EzKey("C-S-l", lazy.spawn("light-locker-command -l")),
    # --------------------------------------------------------------------------------
    # Mgmt
    # --------------------------------------------------------------------------------
    EzKey("M-C-r", lazy.reload_config()),
    EzKey("M-S-r", lazy.restart()),
    EzKey("M-C-q", lazy.shutdown()),
]

groups = make_groups_from_contexts()


# groups = [Group(_) for _ in ["main", "notes", "browser"]]
groups.extend(
    [
        ScratchPad(
            "scratchpad/rough",
            [
                DropDown("term1", terminal, on_focus_lost_hide=False),
            ],
        ),
        ScratchPad(
            "scratchpad/notes",
            [
                DropDown(
                    "zk",
                    "alacritty -e zsh -i -c 'cd $_H; nvim index.md'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "sec__atp",
                    "alacritty -e zsh -i -c '$ENVFILES_PATH/../common/sec/sec__atp.sh'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "sec__spp",
                    "alacritty -e zsh -i -c '$ENVFILES_PATH/../common/sec/sec__spp.sh'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "areas/workflow",
                    "alacritty -e zsh -i -c 'cd $_F/areas/workflow/; nvim'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "sec__dry",
                    "alacritty -e zsh -i -c '$ENVFILES_PATH/../common/sec/sec__dry.sh'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "tmp",
                    "alacritty -e zsh -i -c 'cd $_F/tmp/; nvim'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
            ],
            single=True,
        ),
    ]
)

layouts = [
    Bonsai(**{}),
    layout.MonadWide(ratio=0.72, border_width=1),
    layout.Max(),
    layout.Bsp(),
    # layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="source code pro",
    fontsize=19,
    padding=4,
)
extension_defaults = widget_defaults.copy()


def build_bar_widgets():
    widgets = [
        widget.CurrentLayout(),
        widget.AGroupBox(padding=100),
        widget.Prompt(),
        widget.WindowName(),
        widget.Systray(),
        widget.Volume(padding=10),
        widget.Clock(format=" %a, %d %b %Y %H:%M"),
        widget.QuickExit(),
    ]
    if utils.is_mobile_device():
        systray_index = next(
            i for i, w in enumerate(widgets) if type(w) is widget.Systray
        )
        battery_widget = widget.Battery(
            charge_char="▲",
            discharge_char="▼",
        )
        widgets.insert(systray_index, battery_widget)
    return widgets


screens = [
    Screen(bottom=bar.Bar(build_bar_widgets(), 26)),
    Screen(),
    Screen(),
]

# Drag floating layouts.
mouse = [
    Drag(
        ["mod4"],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        ["mod4"],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click(["mod4"], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="qbittorrent"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="VeraCrypt"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits.
wmname = "LG3D"


@hook.subscribe.client_new
def handle_floatation(window):
    if any(
        [
            _is_util_mode_editor(window),
            _is_firefox_dialog(window),
        ]
    ):
        window.floating = True


def _is_util_mode_editor(window):
    wm_class = window.window.get_wm_class()
    if wm_class[0] == "util_mode_editor":
        # x,y positioning seems to be ignored...
        window.place(100, 100, 2000, 800, 1, "#ffffff")
        return True
    return False


def _is_firefox_dialog(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()

    # Dialogs
    if all(
        [
            wm_class[0] == "Places",
            wm_class[1].startswith("firefox"),
            w_name == "Library",
        ]
    ):
        return True

    if wm_class[1].startswith("firefox") and "private browsing" in w_name.lower():
        return True

    return False


@hook.subscribe.startup_once
def autostart():
    if DOTFILES_PATH is not None:
        xcape_path = os.path.join(DOTFILES_PATH, "scripts/keyboard_mods.sh")
        subprocess.Popen(["/bin/zsh", xcape_path])

    # Screen locker daemon
    subprocess.Popen(["/usr/bin/light-locker"])

    # Start dropbox
    subprocess.Popen("/usr/bin/dropbox")

    # Redshift for color temperature mods according to time of day.
    # Manually setting `lat:long` of home city
    subprocess.Popen(["/usr/bin/redshift", "-l", "28.6542:77.2373"])

    # Start udiskie daemon to watch for connected disks
    subprocess.Popen(["/usr/bin/udiskie", "-s"])

    # Start NetworkManager systray applet
    subprocess.Popen(["/usr/bin/nm-applet", "--indicator"])
