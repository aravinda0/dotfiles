# Hacky implementation of contextual workflow

import socket

from libqtile import hook, qtile, widget
from libqtile.config import Group

# TODO:
# - easier switcher within groupset? eg. a-d/a-f (can't use mod...)

contexts = [
    {
        "name": "work",
        "main": {
            "preferred_display": {
                "nexus": 0,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1", "2", "3", "4"],
        },
        "notes": {
            "preferred_display": {
                "nexus": 1,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1", "2"],
        },
        "browser": {
            "preferred_display": {
                "nexus": 2,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1", "2"],
        },
    },
    {
        "name": "study: topic1",
        "main": {
            "preferred_display": {
                "nexus": 0,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "notes": {
            "preferred_display": {
                "nexus": 1,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "browser": {
            "preferred_display": {
                "nexus": 2,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
    },
    {
        "name": "study: topic2",
        "main": {
            "preferred_display": {
                "nexus": 0,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "notes": {
            "preferred_display": {
                "nexus": 1,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "browser": {
            "preferred_display": {
                "nexus": 2,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
    },
    {
        "name": "study: playground",
        "main": {
            "preferred_display": {
                "nexus": 0,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "notes": {
            "preferred_display": {
                "nexus": 1,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "browser": {
            "preferred_display": {
                "nexus": 2,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
    },
    {
        "name": "craft",
        "main": {
            "preferred_display": {
                "nexus": 0,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "notes": {
            "preferred_display": {
                "nexus": 1,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "browser": {
            "preferred_display": {
                "nexus": 2,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
    },
    {
        "name": "study: pkm",
        "main": {
            "preferred_display": {
                "nexus": 0,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "notes": {
            "preferred_display": {
                "nexus": 1,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "browser": {
            "preferred_display": {
                "nexus": 2,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
    },
    {
        "name": "misc",
        "main": {
            "preferred_display": {
                "nexus": 0,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "notes": {
            "preferred_display": {
                "nexus": 1,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
        "browser": {
            "preferred_display": {
                "nexus": 2,
                "scout": 0,
                "ragebox": 0,
            },
            "groups": ["1"],
        },
    },
]
contexts_map = dict((item["name"], item) for item in contexts)


active_context = contexts[0]["name"]
active_group_set = "main"


class ContextGroupBox(widget.GroupBox):
    @property
    def groups(self):
        global active_context
        return [
            g for g in qtile.groups if parse_group_name(g.name)[0] == active_context
        ]


def make_groups_from_contexts():
    groups = []
    group_set_names = ["main", "notes", "browser"]

    for context in contexts:
        for group_set_name in group_set_names:
            for group_name in context[group_set_name]["groups"]:
                groups.append(
                    Group(
                        normalize_group_name(
                            context["name"], group_set_name, group_name
                        ),
                        label=f"{group_set_name}: {group_name}",
                    )
                )

    return groups


def normalize_group_name(context, group_set, group):
    return f"{context} | {group_set} | {group}"


def parse_group_name(group_name):
    context, group_set, group = None, None, None
    frags = group_name.split("|")
    if len(frags) == 3:
        context, group_set, group = [i.strip() for i in frags]
    return context, group_set, group


def activate_context(context):
    global active_context
    active_context = context

    # Bleh. Order important here. Last one gets focus.
    activate_group_set("browser")
    activate_group_set("notes")
    activate_group_set("main")


def activate_group_set(group_set_name):
    global active_context
    global active_group_set

    # TODO: check current group. if already in GS, don't do anything.

    context_info = contexts_map[active_context]
    group = context_info[group_set_name].get("last_active_group")
    if (group is None) or (group not in context_info[group_set_name]["groups"]):
        group = context_info[group_set_name]["groups"][0]

    active_group_set = group_set_name
    screen = context_info[group_set_name]["preferred_display"][socket.gethostname()]
    activate_standard_group(group, screen)
    qtile.focus_screen(screen)


def activate_standard_group(standard_group_name, screen=None):
    global active_context
    global active_group_set

    context_info = contexts_map[active_context]
    group_set_info = context_info[active_group_set]

    if standard_group_name in group_set_info["groups"]:
        normalized_group = normalize_group_name(
            active_context, active_group_set, standard_group_name
        )

        qtile.groups_map[normalized_group].cmd_toscreen(screen, toggle=False)


def cycle_group_in_group_set(step=1):
    global active_context
    global active_group_set

    context_info = contexts_map[active_context]
    group_set_info = context_info[active_group_set]

    _, _, group = parse_group_name(qtile.current_group.name)
    groups = group_set_info["groups"]
    index = groups.index(group)
    next_group = groups[(index + step) % len(groups)]

    activate_standard_group(next_group)


@hook.subscribe.setgroup
def sync_contexts():
    context, group_set, group = parse_group_name(qtile.current_group.name)
    if all([context, group_set, group]):
        group_set_info = contexts_map[context][group_set]
        if group in group_set_info["groups"]:
            group_set_info["last_active_group"] = group
