module Jekyll
  class RsyncImageGenerator < Generator
    def generate(site)
      system("mkdir -p #{site.config['destination']}");

      root = site.config['source']
      site.config['rsync_copy'].each do |path|
        full_path = File.join(root,path)
        new_path = path[1..-1]
        system("rsync --archive --delete #{full_path}/ #{site.config['destination']}/#{new_path}/")
      end
    end
  end
end