import os
import subprocess
from pathlib import Path

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
from qtile_bonsai import Bonsai, BonsaiBar
from qtile_bonsai.theme import Gruvbox

import colors
import utils
from workspaces import (
    activate_context,
    activate_group_set,
    activate_standard_group,
    cycle_group_in_group_set,
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
        cycle_group_in_group_set(step)

    return inner


rofi_run_cmd = "rofi -show drun -m -1"

# keycodes: https://github.com/qtile/qtile/blob/master/libqtile/backend/x11/xkeysyms.py
keys = [
    # --------------------------------------------------------------------------------
    # qtile-bonsai
    # --------------------------------------------------------------------------------
    EzKey("M-v", lazy.layout.spawn_split(terminal, "x")),
    EzKey("M-S-v", lazy.layout.spawn_split(terminal, "x", position="previous")),
    EzKey("M-x", lazy.layout.spawn_split(terminal, "y")),
    EzKey("M-S-x", lazy.layout.spawn_split(terminal, "y", position="previous")),
    EzKey("M-n", lazy.layout.spawn_tab(terminal)),
    EzKey("M-t", lazy.layout.spawn_tab(terminal)),
    EzKey("M-S-n", lazy.layout.spawn_tab(terminal, new_level=True)),
    EzKey("M-S-t", lazy.layout.spawn_tab(terminal, new_level=True)),
    EzKey("M-p", lazy.layout.spawn_tab(rofi_run_cmd)),
    EzKey("M-S-p", lazy.layout.spawn_tab(rofi_run_cmd, new_level=True)),
    EzKey("A-d", lazy.layout.prev_tab()),
    EzKey("A-f", lazy.layout.next_tab()),
    EzKey("M-h", lazy.layout.left()),
    EzKey("M-l", lazy.layout.right()),
    EzKey("M-k", lazy.layout.up()),
    EzKey("M-j", lazy.layout.down()),
    EzKey("M-C-h", lazy.layout.resize("left", 85)),
    EzKey("M-C-l", lazy.layout.resize("right", 85)),
    EzKey("M-C-k", lazy.layout.resize("up", 85)),
    EzKey("M-C-j", lazy.layout.resize("down", 85)),
    EzKey("C-S-r", lazy.layout.rename_tab()),
    EzKey("M-S-h", lazy.layout.swap("left")),
    EzKey("M-S-l", lazy.layout.swap("right")),
    EzKey("M-S-k", lazy.layout.swap("up")),
    EzKey("M-S-j", lazy.layout.swap("down")),
    EzKey("A-S-d", lazy.layout.swap_tabs("previous")),
    EzKey("A-S-f", lazy.layout.swap_tabs("next")),
    EzKey("M-o", lazy.layout.select_container_outer()),
    EzKey("M-i", lazy.layout.select_container_inner()),
    # ----------
    # precise tab selection
    EzKey("M-1", lazy.layout.focus_nth_tab(1)),
    EzKey("M-2", lazy.layout.focus_nth_tab(2)),
    EzKey("M-3", lazy.layout.focus_nth_tab(3)),
    EzKey("M-4", lazy.layout.focus_nth_tab(4)),
    EzKey("M-5", lazy.layout.focus_nth_tab(5)),
    # ----------
    # precise pane selection
    EzKey(
        "C-1", lazy.layout.focus_nth_window(1, ignore_inactive_tabs_at_levels=[1, 2])
    ),
    EzKey(
        "C-2", lazy.layout.focus_nth_window(2, ignore_inactive_tabs_at_levels=[1, 2])
    ),
    EzKey(
        "C-3", lazy.layout.focus_nth_window(3, ignore_inactive_tabs_at_levels=[1, 2])
    ),
    EzKey(
        "C-4", lazy.layout.focus_nth_window(4, ignore_inactive_tabs_at_levels=[1, 2])
    ),
    EzKey(
        "C-5", lazy.layout.focus_nth_window(5, ignore_inactive_tabs_at_levels=[1, 2])
    ),
    KeyChord(
        ["mod4"],
        "w",
        [
            EzKey("1", _activate_standard_group("1")),
            EzKey("2", _activate_standard_group("2")),
            EzKey("3", _activate_standard_group("3")),
            EzKey("4", _activate_standard_group("4")),
            EzKey("5", _activate_standard_group("5")),
            EzKey("6", _activate_standard_group("6")),
            EzKey("7", _activate_standard_group("7")),
            EzKey("n", lazy.layout.normalize()),
            EzKey("f", lazy.window.toggle_floating()),
            EzKey("M-<Return>", lazy.window.toggle_fullscreen()),
            EzKey("o", lazy.layout.pull_out()),
            EzKey("u", lazy.layout.pull_out_to_tab()),
            KeyChord(
                [],
                "m",
                [
                    EzKey("h", lazy.layout.merge_to_subtab("left", normalize=False)),
                    EzKey("l", lazy.layout.merge_to_subtab("right", normalize=False)),
                    EzKey("j", lazy.layout.merge_to_subtab("down", normalize=False)),
                    EzKey("k", lazy.layout.merge_to_subtab("up", normalize=False)),
                    #
                    # Merge whole tabs
                    EzKey("S-h", lazy.layout.merge_tabs("previous")),
                    EzKey("S-l", lazy.layout.merge_tabs("next")),
                ],
            ),
            KeyChord(
                [],
                "i",
                [
                    EzKey("j", lazy.layout.push_in("down")),
                    EzKey("k", lazy.layout.push_in("up")),
                    EzKey("h", lazy.layout.push_in("left")),
                    EzKey("l", lazy.layout.push_in("right")),
                    EzKey(
                        "S-j",
                        lazy.layout.push_in("down", dest_selection="mru_deepest"),
                    ),
                    EzKey(
                        "S-k",
                        lazy.layout.push_in("up", dest_selection="mru_deepest"),
                    ),
                    EzKey(
                        "S-h",
                        lazy.layout.push_in("left", dest_selection="mru_deepest"),
                    ),
                    EzKey(
                        "S-l",
                        lazy.layout.push_in("right", dest_selection="mru_deepest"),
                    ),
                ],
            ),
            EzKey("v", lazy.layout.spawn_split(rofi_run_cmd, "x")),
            EzKey("x", lazy.layout.spawn_split(rofi_run_cmd, "y")),
            EzKey("t", lazy.layout.spawn_tab(rofi_run_cmd)),
            EzKey("C-v", lazy.layout.toggle_container_select_mode()),
            EzKey("S-t", lazy.layout.spawn_tab(rofi_run_cmd, new_level=True)),
            EzKey("<Delete>", lazy.spawn("light-locker-command -l")),
            EzKey("C-r", lazy.reload_config()),
            EzKey("M-r", lazy.restart()),
            EzKey("M-q", lazy.shutdown()),
        ],
    ),
    # --------------------------------------------------------------------------------
    # Groups organization
    # --------------------------------------------------------------------------------
    EzKey("M-C-1", _activate_context("work")),
    EzKey("M-C-2", _activate_context("study")),
    EzKey("M-C-3", _activate_context("playground")),
    EzKey("M-d", _activate_group_set("main")),
    EzKey("M-e", _activate_group_set("notes")),
    EzKey("M-s", _activate_group_set("browser")),
    EzKey("C-M-f", _cycle_group_in_group_set(1)),
    EzKey("C-M-d", _cycle_group_in_group_set(-1)),
    # --------------------------------------------------------------------------------
    # Scratchpads
    # --------------------------------------------------------------------------------
    EzKey("M-<backslash>", lazy.group["scratchpad/rough"].dropdown_toggle("term1")),
    EzKey("C-0", lazy.group["scratchpad/notes"].dropdown_toggle("zk")),
    EzKey("C-A-0", lazy.group["scratchpad/notes"].dropdown_toggle("sec__dry")),
    EzKey("C-8", lazy.group["scratchpad/notes"].dropdown_toggle("areas/workflow")),
    EzKey("C-A-8", lazy.group["scratchpad/notes"].dropdown_toggle("dotfiles")),
    EzKey("C-9", lazy.group["scratchpad/notes"].dropdown_toggle("sec__atp")),
    EzKey("C-<backslash>", lazy.group["scratchpad/notes"].dropdown_toggle("tmp")),
    EzKey(
        "C-<BackSpace>",
        lazy.group["scratchpad/notes"].hide_all(),
    ),
    EzKey(
        "C-<grave>",
        lazy.group["scratchpad/notes"].hide_all(),
    ),
    EzKey(
        "C-S-<backslash>",
        lazy.group["scratchpad/notes"].hide_all(),
    ),
    # --------------------------------------------------------------------------------
    # Window actions
    # --------------------------------------------------------------------------------
    EzKey("M-S-<Return>", lazy.layout.toggle_split()),
    EzKey("M-<Tab>", lazy.next_layout()),
    # --------------------------------------------------------------------------------
    # Audio
    # --------------------------------------------------------------------------------
    EzKey("<XF86AudioRaiseVolume>", lazy.spawn("amixer set -q Master 3%+")),
    EzKey("<XF86AudioLowerVolume>", lazy.spawn("amixer set -q Master 3%-")),
    EzKey("<XF86AudioMute>", lazy.spawn("amixer set -q Master toggle")),
    # --------------------------------------------------------------------------------
    # Misc
    # --------------------------------------------------------------------------------
    EzKey("M-<Return>", lazy.spawn(terminal)),
    EzKey("M-r", lazy.spawncmd()),
    EzKey("M-8", lazy.spawn("keepmenu")),
    KeyChord(
        ["mod4"],
        "a",
        [
            EzKey("w", lazy.spawn("qutebrowser")),
            EzKey("f", lazy.spawn("firefox-developer-edition")),
            EzKey("t", lazy.spawn("qbittorrent")),
        ],
    ),
    EzKey("M-<BackSpace>", lazy.window.kill()),
    EzKey("C-q", lazy.window.kill()),
]

groups = make_groups_from_contexts()
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
                    "areas/workflow",
                    "alacritty -e zsh -i -c 'cd $_F/areas/workflow/; nvim'",
                    on_focus_lost_hide=False,
                    width=0.95,
                    height=0.95,
                    x=0.02,
                    y=0.02,
                ),
                DropDown(
                    "dotfiles",
                    f"alacritty --working-directory {DOTFILES_PATH}",
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
    Bonsai(
        **{
            "window.single.border_size": 0,
        }
    ),
]

widget_defaults = {
    "font": "source code pro",
    "fontsize": 22,
    "icon_size": 22,
    "background": Gruvbox.bg0_hard,
    "foreground": Gruvbox.fg1,
}
extension_defaults = widget_defaults.copy()
monitoring_widgets_defaults = {
    "update_interval": 2,
    "background": colors.dull_yellow,
    "foreground": Gruvbox.fg1,
    "padding": 6,
}


def build_bar_widgets():
    widgets = [
        BonsaiBar(
            **{
                "bg_color": Gruvbox.bg0_hard,
            }
        ),
        widget.CurrentLayout(padding=10),
        widget.AGroupBox(fmt="  {}  ", padding=50),
        widget.WindowName(),
        widget.Prompt(),
        *build_bar_monitoring_widgets(),
        widget.Spacer(length=40),
        widget.Volume(fmt="󰕾 {}"),
        widget.Systray(),
        widget.Spacer(length=40),
        widget.Clock(format="%a, %d %b %Y %H:%M"),
    ]
    if utils.is_mobile_device():
        systray_index = next(
            i for i, w in enumerate(widgets) if type(w) is widget.Systray
        )
        battery_widget = widget.Battery(
            low_percentage=0.15,
            charge_char="▲",
            discharge_char="▼",
        )
        widgets.insert(systray_index, battery_widget)
    return widgets


def build_bar_monitoring_widgets():
    return [
        widget.TextBox(
            text="",
            foreground=monitoring_widgets_defaults["background"],
            padding=0,
        ),
        widget.CPU(
            **monitoring_widgets_defaults,
            format="  {load_percent}%",
        ),
        widget.Memory(
            **monitoring_widgets_defaults,
            measure_mem="G",
            format="󰈀 {NotAvailable:.2f}{mm}",
        ),
        widget.ThermalSensor(
            **monitoring_widgets_defaults,
            format="󰔐 {temp:.0f}{unit}",
            tag_sensor="Tctl",
        ),
        widget.TextBox(
            text="",
            background=monitoring_widgets_defaults["background"],
            foreground=widget_defaults["background"],
            padding=0,
        ),
    ]


bar_config = {}
screens = [
    Screen(top=bar.Bar(build_bar_widgets(), 32, **bar_config)),
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
        Match(wm_class="ssh-askpass"),
        Match(wm_class="qbittorrent"),
        Match(title="pinentry"),  # GPG key password entry
        Match(title="VeraCrypt"),
    ],
    border_normal=colors.dull_yellow,
    border_focus=colors.bright_yellow,
    border_width=2,
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
    if wm_class and wm_class[0] == "util_mode_editor":
        # x,y positioning seems to be ignored...
        window.place(100, 100, 2000, 800, 1, "#ffffff")
        return True
    return False


def _is_firefox_dialog(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()

    if not wm_class:
        return False

    # Dialogs
    if all(
        [
            wm_class[0] == "Places",
            wm_class[1].startswith("firefox"),
            w_name == "Library",
        ]
    ):
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

    # Set wallpaper
    subprocess.Popen(
        [
            "/usr/bin/feh",
            "--bg-scale",
            Path(DOTFILES_PATH) / "wallpapers/gruv-berries.png",
        ]
    )

    activate_context("work")
