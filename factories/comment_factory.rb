Factory.define :comment do |comment|
  comment.text   "test test test"
  comment.user   { |u| u.association(:user) }
  comment.ticket { |t| t.association(:ticket) }
end
