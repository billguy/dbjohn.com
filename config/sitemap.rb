# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = APP_CONFIG['host']

SitemapGenerator::Sitemap.create do

  add '/contact'

  Page.find_each do |page|
    add page.permalink, :lastmod => page.updated_at
  end

  Blog.where(published: true).each do |blog|
    add blog.permalink, :lastmod => blog.updated_at
  end

  Pic.where(published: true).each do |pic|
    add pic.permalink, :lastmod => pic.updated_at
  end

end
