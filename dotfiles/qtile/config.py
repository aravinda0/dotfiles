import os
import re
import subprocess

import workspaces as ws
from libqtile import bar, hook, layout, widget
from libqtile.config import (
    Click,
    Drag,
    DropDown,
    EzKey,
    Group,
    Match,
    ScratchPad,
    Screen,
)
from libqtile.lazy import lazy
from workspaces import (
    ContextGroupBox,
    activate_context,
    activate_group_set,
    activate_standard_group,
    make_groups_from_contexts,
)

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
        ws.cycle_group_in_group_set(step)

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
    # Groups organization
    # --------------------------------------------------------------------------------
    EzKey("M-C-1", _activate_context("work")),
    EzKey("M-C-2", _activate_context("study: topic1")),
    EzKey("M-C-3", _activate_context("study: topic2")),
    EzKey("M-C-4", _activate_context("study: playground")),
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
    EzKey("A-f", _cycle_group_in_group_set(1)),
    EzKey("A-d", _cycle_group_in_group_set(-1)),
    # --------------------------------------------------------------------------------
    # Scratchpads
    # --------------------------------------------------------------------------------
    EzKey("M-<backslash>", lazy.group["scratchpad/rough"].dropdown_toggle("term1")),
    EzKey("M-C-<backslash>", lazy.group["scratchpad/rough"].dropdown_toggle("term2")),
    EzKey("C-0", lazy.group["scratchpad/notes"].dropdown_toggle("zk")),
    EzKey(
        "C-A-0", lazy.group["scratchpad/notes"].dropdown_toggle("areas/tech_prowess")
    ),
    EzKey("C-9", lazy.group["scratchpad/notes"].dropdown_toggle("areas/self++")),
    EzKey("C-A-9", lazy.group["scratchpad/notes"].dropdown_toggle("diary")),
    EzKey("C-8", lazy.group["scratchpad/notes"].dropdown_toggle("areas/workflow")),
    EzKey("C-<backslash>", lazy.group["scratchpad/notes"].dropdown_toggle("tmp")),
    EzKey(
        "C-<BackSpace>",
        lazy.group["scratchpad/notes"].hide_all(),
        desc="Hide all notes scratchpad windows",
    ),
    # --------------------------------------------------------------------------------
    # Window actions
    # --------------------------------------------------------------------------------
    EzKey("M-h", lazy.layout.left(), desc="Move focus to left"),
    EzKey("M-l", lazy.layout.right(), desc="Move focus to right"),
    EzKey("M-j", lazy.layout.down(), desc="Move focus down"),
    EzKey("M-k", lazy.layout.up(), desc="Move focus up"),
    EzKey("M-C-h", resize_left, desc="Grow window to the left"),
    EzKey("M-C-l", resize_right, desc="Grow window to the right"),
    EzKey("M-C-j", resize_down, desc="Grow window down"),
    EzKey("M-C-k", resize_up, desc="Grow window up"),
    EzKey("M-S-h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    EzKey("M-S-l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    EzKey("M-S-j", lazy.layout.shuffle_down(), desc="Move window down"),
    EzKey("M-S-k", lazy.layout.shuffle_up(), desc="Move window up"),
    EzKey("C-S-n", lazy.layout.normalize(), desc="Reset all window sizes"),
    EzKey("C-S-f", lazy.window.toggle_floating(), desc="Toggle floating mode"),
    EzKey(
        "C-S-<Return>", lazy.window.toggle_fullscreen(), desc="Toggle full-screen mode"
    ),
    EzKey("M-<space>", lazy.layout.next(), desc="Move window focus to other window"),
    EzKey(
        "M-S-<Return>",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    EzKey("M-<Tab>", lazy.next_layout(), desc="Toggle between layouts"),
    # --------------------------------------------------------------------------------
    # Misc
    # --------------------------------------------------------------------------------
    EzKey("M-<Return>", lazy.spawn(terminal), desc="Launch terminal"),
    EzKey("M-r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    EzKey("M-<BackSpace>", lazy.window.kill(), desc="Kill focused window"),
    EzKey(
        "C-S-l",
        lazy.spawn("light-locker-command -l"),
        desc="Lock system",
    ),
    # --------------------------------------------------------------------------------
    # Mgmt
    # --------------------------------------------------------------------------------
    EzKey("M-C-r", lazy.reload_config(), desc="Reload Qtile config"),
    EzKey("M-S-r", lazy.restart(), desc="Restart Qtile"),
    EzKey("M-C-q", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = make_groups_from_contexts()


# groups = [Group(_) for _ in ["main", "notes", "browser"]]
groups.extend(
    [
        ScratchPad(
            "scratchpad/rough",
            [
                DropDown("term1", terminal, on_focus_lost_hide=False),
                DropDown("term2", terminal, on_focus_lost_hide=False),
            ],
        ),
        ScratchPad(
            "scratchpad/notes",
            [
                DropDown(
                    "zk",
                    "alacritty -e zsh -c 'cd $HOME/.dency/forge/notes; nvim index.md'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "areas/tech_prowess",
                    "alacritty -e zsh -c 'cd $HOME/.dency/forge/areas/tech_prowess; nvim'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "areas/self++",
                    "alacritty -e zsh -c 'cd $HOME/.dency/forge/areas/self++; nvim'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "areas/workflow",
                    "alacritty -e zsh -c 'cd $HOME/.dency/forge/areas/workflow/; nvim'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "diary",
                    "alacritty -e zsh -c 'cd $HOME/.s/.j; nvim diary/diary.md'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "tmp",
                    "alacritty -e zsh -c 'cd $HOME/.dency/forge/tmp/; nvim'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
            ],
        ),
    ]
)
# numbered_groups = [Group(i) for i in "123456789"]
# groups.extend(numbered_groups)
#
# for i in numbered_groups:
#     keys.extend(
#         [
#             # mod1 + letter of group = switch to group
#             Key(
#                 [mod],
#                 i.name,
#                 lazy.group[i.name].toscreen(),
#                 desc="Switch to group {}".format(i.name),
#             ),
#             # mod1 + shift + letter of group = switch to & move focused window to group
#             Key(
#                 [mod, "shift"],
#                 i.name,
#                 lazy.window.togroup(i.name, switch_group=True),
#                 desc="Switch to & move focused window to group {}".format(i.name),
#             ),
#             # Or, use below if you prefer not to switch to that group.
#             # # mod1 + shift + letter of group = move focused window to group
#             # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
#             #     desc="move focused window to group {}".format(i.name)),
#         ]
#     )

layouts = [
    layout.Bsp(),
    layout.MonadWide(ratio=0.72, border_width=1),
    layout.Max(),
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

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                ContextGroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                widget.Clock(format=" %a, %d %b %Y %H:%M"),
                widget.QuickExit(),
            ],
            26,
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                ContextGroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Clock(format="%a, %d %b %Y %H:%M"),
                widget.QuickExit(),
            ],
            26,
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                ContextGroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Clock(format=" %a, %d %b %Y %H:%M"),
                widget.QuickExit(),
            ],
            26,
        ),
    ),
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
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title=re.compile(r"Firefox Developer Edition \(Private Browsing\)")),
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
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


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