function __fzf_complete_bazel_test
  command bazelisk query "kind('(test|test_suite) rule', //...)" 2> /dev/null | fzf | read -l selected
  echo $selected
end

function __fzf_complete_bazel
  set tokens (string split ' ' -- $argv)
  
  if test (count $tokens) -ge 3; and test $tokens[3] = "test"
    __fzf_complete_bazel_test
  else
    command bazelisk query //... 2> /dev/null | fzf | read -l selected
    echo $selected
  end
end

function _fzf_complete_bazel
  __fzf_complete_bazel | read -l selected
  echo $selected
end

complete -c bazel -f -a '(_fzf_complete_bazel)'
