
# Source helper scripts provided by pew to display venv name in shell etc
# NOTE: This seems to be farily slow. Picked out relevant stuff from there and just using
# that instead.
# See: https://github.com/berdario/pew/issues/87
# source $(pew shell_config)

function virtualenv_prompt_info() {
    if [ -n "$VIRTUAL_ENV" ]; then
        local name=$(basename $VIRTUAL_ENV)
        echo "($name)"
    fi
}
PS1="$(virtualenv_prompt_info)$PS1"
