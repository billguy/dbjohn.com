class Blog < ActiveRecord::Base

  validates_presence_of :title, :content
  has_permalink(:title, true)

  acts_as_taggable
  ActsAsTaggableOn.remove_unused_tags = true
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.force_parameterize = true

  paginates_per 4

  scope :latest, ->(num=1){
    where(published: true).order(created_at: :desc).limit(num)
  }

  scope :filter_by, ->(filter=nil, published=true){
    case filter
      when /year/
        created = 1.year.ago
      when /month/
        created = 1.month.ago
      when /day/
        created = DateTime.now.beginning_of_day
      else
        created = 5.years.ago
    end
    if published
      where("blogs.created_at > ? and blogs.published = ?", created, published).order(created_at: :desc)
    else
      where("blogs.created_at > ?", created).order(created_at: :desc)
    end
  }


  def to_param
    permalink
  end

end
