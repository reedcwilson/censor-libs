module Obscenity
  class Base
    class << self

      def blacklist
        @blacklist ||= set_list_content(Obscenity.config.blacklist)
      end

      def blacklist=(value)
        @blacklist = value == :default ? set_list_content(Obscenity::Config.new.blacklist) : value end

      def whitelist
        @whitelist ||= set_list_content(Obscenity.config.whitelist)
      end

      def whitelist=(value)
        @whitelist = value == :default ? set_list_content(Obscenity::Config.new.whitelist) : value
      end

      def madlibs
        @madlibs ||= set_list_content(Obscenity.config.madlibs)
      end

      def madlibs=(value)
        @madlibs = value == :default ? set_list_content(Obscenity::Config.new.madlibs) : value
      end

      def profane?(text)
        return(false) unless text.to_s.size >= 3
        blacklist.each do |foul|
          return(true) if text =~ /\b#{foul}\b/i && !whitelist.include?(foul)
        end
        false
      end

      def sanitize(text)
        return(text) unless text.to_s.size >= 3
        blacklist.each do |foul|
          text.gsub!(/\b#{foul[0]}\b/i, do_madlibs(foul)) unless whitelist.include?(foul[0])
        end
        @scoped_replacement = nil
        text
      end

      def replacement(chars)
        @scoped_replacement = chars
        self
      end

      def offensive(text)
        words = []
        return(words) unless text.to_s.size >= 3
        blacklist.each do |foul|
          words << foul if text =~ /\b#{foul}\b/i && !whitelist.include?(foul)
        end
        words.uniq
      end

      def do_madlibs(word)
        case word[1]
          when "noun" 
            '[' << get_random_word(madlibs['noun']) << ']'
          when "noun-plural"
            '[' << get_random_word(madlibs['noun']) << 's' << ']'
          when "adjective"
            '[' << get_random_word(madlibs['adjective']) << ']'
          when "verb"
            '[' << get_random_word(madlibs['verb']) << ']'
          when "verb-past"
            '[' << get_random_word(madlibs['verb-past']) << ']'
          when "verb-present"
            '[' << get_random_word(madlibs['verb-present']) << ']'
          when "adverb"
            '[' << get_random_word(madlibs['adverb']) << ']'
          when "exclaim"
            '[' << get_random_word(madlibs['exclaim']) << ']'
          else replace(word[0])
        end
      end

      def replace(word)
        content = @scoped_replacement || Obscenity.config.replacement
        case content
          when :vowels then word.gsub(/[aeiou]/i, '*')
          when :stars  then '*' * word.size
          when :nonconsonants then word.gsub(/[^bcdfghjklmnpqrstvwxyz]/i, '*')
          when :default, :garbled then '$@!#%'
        else content
        end
      end

      private
      def set_list_content(list)
        case list
          when Array then list
          when String, Pathname then YAML.load_file( list.to_s )
          else []
        end
      end

      private
      def get_random_word(words)
        words[rand(0..words.length-1)].to_s
      end

    end
  end
end
