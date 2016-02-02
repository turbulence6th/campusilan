require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.campusilan.com'
SitemapGenerator::Sitemap.create do
	add '/kategoriler/ikincielilan', :priority => 1
	add '/kategoriler/evarkadasi', :priority => 1
	add '/kategoriler/ozelders', :priority => 1
	add '/kategoriler', :priority => 1
	add '/hakkimizda', :changefreq => 'monthly', :priority => 0.1
	add '/iletisim', :changefreq => 'monthly', :priority => 0.1
	add '/kullanimkosullari', :changefreq => 'monthly', :priority => 0.1
	add '/reklam', :changefreq => 'monthly', :priority => 0.1
	add '/yardim', :changefreq => 'monthly', :priority => 0.1
	add '/risksizalisveris', :changefreq => 'monthly', :priority => 0.1
  add '/duyurular', :changefreq => 'monthly', :priority => 0.1
  add '/hizmetlerimiz', :changefreq => 'monthly', :priority => 0.1
  add 'sifremiunuttum', :changefreq => 'monthly', :priority => 0.1
  add '/ilanver', :changefreq => 'monthly', :priority => 0.8
  add '/ikinciel', :changefreq => 'daily', :priority => 1
  add '/evarkadasi', :changefreq => 'daily', :priority => 1
  add '/ozelders', :changefreq => 'daily', :priority => 1
  add '/kayitol', :changefreq => 'monthly', :priority => 0.8
  add '/girisyap', :changefreq => 'monthly', :priority => 0.8
  add '/firsatlar', :priority => 1
  add '/universiteler', :priority => 1
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
