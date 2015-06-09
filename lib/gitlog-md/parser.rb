require 'grit'

module GitlogMD
  class Parser
    def make_md options
      output_file = options[:output_file]
      repo_dir    = options[:repo_dir]
      branch      = options[:branch]

      puts "Using output file: #{output_file}"
      puts "Repository: #{repo_dir}, branch: #{branch}"

      output = "# #{File.basename(File.absolute_path(repo_dir))} - History\n"

      repo = Grit::Repo.new(repo_dir)
      head = Grit::Tag.new(repo.commits(branch).first.sha, repo, repo.commits(branch).first.id)
      # commits for this branch
      commits = repo.commits(branch, repo.commit_count).map{ |commit| commit.sha }
      # remove tags not associated with this branch
      tags = repo.tags.delete_if{ |t| not commits.include?(t.commit.sha) }

      tags = tags + [head]
      tags.sort! {|x,y| y.commit.authored_date <=> x.commit.authored_date}

      output << "## Tags\n"
      tags.each do |tag|
        tag_name = tag.name
        if tag == tags.first
          tag_name = 'LATEST'
        end
        output << "* [#{tag_name} - #{tag.commit.authored_date.strftime("%-d %b, %Y")} (#{tag.commit.sha[0,8]})](##{tag_name})\n"
      end

      output << "\n## Details\n"
      tagcount = 0
      tags.each do |tag|
        tag_name = tag.name
        if tag == tags.first
          tag_name = 'LATEST'
        end
        output << "### <a name = \"#{tag_name}\">#{tag_name} - #{tag.commit.authored_date.strftime("%-d %b, %Y")} (#{tag.commit.sha[0,8]})\n\n"
        if (tagcount != tags.size - 1)
          commit_set = repo.commits_between(tags[tagcount + 1].name, tag.name)
          commit_set.sort! {|x,y| y.authored_date <=> x.authored_date }
          commit_set.each do |c|
            output << "* #{c.short_message} (#{c.sha[0,8]})\n\n"
            if c.short_message != c.message
              output << "\n```\n#{c.message.gsub(/```/, "\n")}\n```\n"
            end
          end
        else
          output << "* Initial release.\n"
        end
        tagcount += 1
      end

      File.open(output_file, 'w') { |f| f.write(output) }

      puts "Success, Markdown output sent to #{output_file}"
    end
  end

end
