module FeaturesHelper
  def self.create_and_activate_user(name)
    user = User.create!(
      name:, bio: "Bio of #{name}", photo: "#{name}.jpg", posts_counter: 0
    )
    user.save
    user
  end

  def self.create_posts_for_user(user, count: 1)
    posts = []
    count.times do |i|
      posts << Post.create!(
        user:,
        title: "Post #{i}",
        text: "This is body of post #{i}",
        comments_counter: 0,
        likes_counter: 0
      )
    end
    posts
  end

  def self.create_comments_for_post_by_user(post, user, count: 1)
    comments = []
    count.times do |i|
      comments << Comment.create!(
        user:,
        post:,
        text: "Comment #{i}"
      )
    end
    comments
  end
end
