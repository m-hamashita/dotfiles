# fish_user_paths を config.fish で設定するな - https://qiita.com/HelloRusk/items/ea0089bf80b07aa74d8d

# カーソルをプロンプトの次の行にする
set -g theme_newline_cursor yes
set -g theme_newline_prompt (set_color green; echo ' $ ')
set -g fish_prompt_pwd_dir_length 0

# コマンドの色を緑に
set fish_color_command green
set fish_color_error red

# manに色を付ける
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
