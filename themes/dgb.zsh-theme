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

function aws_account {
    if [ -n "${CURRENT_AWS_ACCOUNT}" ]; then
        EXPIRES_TS=$(date --date="$AWS_SESSION_EXPIRES" +"%s")
        NOW_TS=$(date +"%s")

        SECS_REMAINING=$(( $EXPIRES_TS - $NOW_TS))

        if [ $SECS_REMAINING -gt 0 ]; then
            HOURS_REMAINING=$(( $SECS_REMAINING / 3600 ))
            SECS_REMAINING=$(( $SECS_REMAINING % 3600 ))

            MINUTES_REMAINING=$(( $SECS_REMAINING / 60 ))

            echo "$CURRENT_AWS_ACCOUNT ${HOURS_REMAINING}h${MINUTES_REMAINING}m"
        else
            echo $CURRENT_AWS_ACCOUNT EXPIRED!
        fi


    fi
}

function java_version {
    java_executable=$(which java)
    if [ -x "$java_executable" ]; then
        echo "☕️ $(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')"
    fi
}

PROMPT='$(clock)$(username)@$(host):$(dir) $(aws_account) $(java_version) $(git_prompt_info)
%_$(prompt_char) '

RPROMPT='$(exit_code)'
