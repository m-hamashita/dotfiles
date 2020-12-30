# fish_user_paths を config.fish で設定するな - https://qiita.com/HelloRusk/items/ea0089bf80b07aa74d8d

# カーソルをプロンプトの次の行にする
set -g theme_newline_cursor yes
set -g theme_newline_prompt (set_color green; echo ' $ ')
set -g fish_prompt_pwd_dir_length 0


# set -x LESSOPEN "| /usr/local/Cellar/source-highlight/3.1.9_2/bin/src-hilite-lesspipe.sh %s"
# set -x LESS '-R'


#manに色を付ける
set -x MANPAGER 'less -R'
function man
	env \
			LESS_TERMCAP_mb=(printf "\e[1;31m") \
			LESS_TERMCAP_md=(printf "\e[1;31m") \
			LESS_TERMCAP_me=(printf "\e[0m") \
			LESS_TERMCAP_se=(printf "\e[0m") \
			LESS_TERMCAP_so=(printf "\e[1;44;33m") \
			LESS_TERMCAP_ue=(printf "\e[0m") \
			LESS_TERMCAP_us=(printf "\e[1;32m") \
			man "$argv[1]"
end



# # The next line updates PATH for the Google Cloud SDK.
# if test -f '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/path.zsh.inc'
#     source '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/path.zsh.inc';
# end
#
# # The next line enables shell command completion for gcloud.
# if test -f '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/completion.zsh.inc'
#     source '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/completion.zsh.inc';
# end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# set -x __conda_setup "('/Users/masakatsu.hamashita/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $status -eq 0 ]
#     eval "$__conda_setup"
# else
#     if test -f '/Users/masakatsu.hamashita/opt/anaconda3/etc/profile.d/conda.sh'
#         . '/Users/masakatsu.hamashita/opt/anaconda3/etc/profile.d/conda.sh'
#     else
#         set -x PATH "/Users/masakatsu.hamashita/opt/anaconda3/bin $PATH"
#     end
# end
# set -e __conda_setup
# <<< conda initialize <<<
