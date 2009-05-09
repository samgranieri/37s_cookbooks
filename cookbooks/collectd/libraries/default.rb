
def format_option(option)
  return option if option.match(/^((true)|(false)|(\d+))$/)
  "\"#{option}\""
end

