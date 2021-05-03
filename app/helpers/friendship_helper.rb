module FriendshipHelper
  def can_friend_check(user_one, user_two)
    if user_one == user_two
      message = 'You can\'t send a request to yourself'
    elsif Friendship.find_by(sent_by_id: user_one, sent_to_id: user_two)&.status
      message = 'You are already friends with this user'
    elsif Friendship.exists?(sent_by_id: user_one, sent_to_id: user_two)
      message = 'You can\'t send a request twice'
    elsif Friendship.exists?(sent_to_id: user_one, sent_by_id: user_two)
      message = 'You already have a request from this user'
    end
    message
  end
end
