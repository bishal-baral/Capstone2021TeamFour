module UsersHelper
  # Generate a code that's unique when combined with username
  def gen_code(user)
    friend_code = rand(1000...9999)
    friend_code = rand(1000...9999) while User.where(username: user.username, code: friend_code).count.positive?
    user.code = friend_code
  end

  # Parse review's tags from a string
  def tags_from_string(input_string)
    tags = {}
    input_string.split(' ').each do |pair|
      pair = pair.gsub('-', ' ')
      category, name = pair.split(':')
      tags[category] = name
    end
    tags
  end

  # Filter reviews based on a set of tags
  def filter_reviews(reviews, tags)
    result = []
    reviews.each do |review|
      keep = true
      review_tags = review.tags
      tags.each do |category, name|
        if category == 'title'
          keep = false if name.downcase != review.media.downcase
        elsif review_tags.find_by(category: category.capitalize,
                                  name: name.capitalize).nil?
          keep = false
        end
      end
      result.append(review) if keep
    end
    result
  end
end
