ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
    if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

function exit_code {
    EXIT_CODE=$?
    if [ "$EXIT_CODE" -ne "0" ]; then
        echo " C:%{$fg[red]%}$EXIT_CODE%{$reset_color%} "
    fi

    #echo %(?, ,%{$fg[red]%}FAIL: $?%{$reset_color%})
}

function clock {
    echo "%{$fg[green]%}[%*]%{$reset_color%} "
}

function username {
    echo "%{$fg[magenta]%}%n%{$reset_color%}"
}

function host {
    echo "%{$fg[yellow]%}%m%{$reset_color%}"
}

function dir {
    echo "%{$fg_bold[blue]%}%~%{$reset_color%}"
}

function conditional_git_prompt {
    if [ -z "$ZSH_THEME_DISABLE_GIT_PRMOPT" ]; then
        echo "$(git_prompt_info)"
    fi
}

PROMPT='$(clock)$(username)@$(host):$(dir) $(conditional_git_prompt)
%_$(prompt_char) '

RPROMPT='$(exit_code)'
