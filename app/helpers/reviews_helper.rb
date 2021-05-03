module ReviewsHelper
  # Checks whether these params would make a valid tag
  def valid_tag(cat, name)
    # Prevent either from being empty
    return false if cat == '' || name == '' || cat.nil? || name.nil?

    # Prevent either from being too long
    cat.length < 20 && name.length < 30
  end

  # Create (valid) tags from the inputted hash
  def collect_tags(data)
    iter = 1
    tags = {}

    # Wasn't sure of the best way to have a multitude of tags
    until data["tag_#{iter}_category".to_sym].nil?
      tag_cat = data["tag_#{iter}_category".to_sym]
      tag_name = data["tag_#{iter}_name".to_sym]
      # Don't error on invalid tags
      tags[tag_cat] = tag_name if valid_tag(tag_cat, tag_name)
      iter += 1
    end
    tags
  end

  # Gets a tag if it exists, and otherwise creates it
  def grab_tag(cat, name)
    tag = Tag.find_by(category: cat.capitalize, name: name.capitalize)
    tag = Tag.create(category: cat, name: name) if tag.nil?
    tag
  end

  # Should create or grab tags based on a hash
  def create_tags(tags, review_id)
    tags.each do |cat, name|
      tag = grab_tag(cat, name)
      ReviewTag.create(tag_id: tag.id, review_id: review_id)
    end
  end
end
