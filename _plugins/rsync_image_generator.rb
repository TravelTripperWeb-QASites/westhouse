module Jekyll
  class RsyncImageGenerator < Generator
    def generate(site)
      return
      system('mkdir -p _site');
      system('rsync --archive --delete _images/ _site/images/');
    end
  end
end
