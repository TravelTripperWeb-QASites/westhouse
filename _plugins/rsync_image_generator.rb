module Jekyll
  class RsyncImageGenerator < Generator
    def generate(site)
      system("mkdir -p #{site.config['destination']}");

      site.config['rsync_copy'].each do |path|
        new_path = path[1..-1]
        system("rsync --archive --delete #{path}/ #{site.config['destination']}/#{new_path}/")
      end
    end
  end
end
