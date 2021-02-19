require 'open-uri'
require "byebug"
require "set"

class WordChainer
    def initialize(dictionary_file_name)
        file_dic = open(dictionary_file_name)
        html_dic = file_dic.read
        @dictionary = html_dic.split(" ")
    end

    def adjacent_words(word)
        adj_words = []
        dictionary = @dictionary.to_set
        dictionary.each do |dword|
            count = 0
            if word.length == dword.length 
                for i in 0...word.length
                    count += 1 if word[i] == dword[i]
                end    
                adj_words << dword if count == word.length - 1
            end
        end
        adj_words
    end

    def run(source, target)
        # debugger
        @current_words = [source]
        @all_seen_words = { source => nil }
        catch(:done) do
            until @current_words.empty? do
                @new_current_words = []
                explore_current_words(target)
                @current_words = @new_current_words
            end
        end
        build_path(target)
    end

    def explore_current_words(target)
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                unless @all_seen_words.has_key?(adjacent_word)
                    @new_current_words << adjacent_word
                    @all_seen_words[adjacent_word] = current_word
                    throw(:done) if adjacent_word == target
                end
            end
        end
    end

    def build_path(target)
        chain = [target]
        chain << target while target = @all_seen_words[target]
        chain = chain.reverse
        puts chain || "No chain found!"
    end
    
end

word_chainer = WordChainer.new("https://assets.aaonline.io/fullstack/ruby/projects/word_chains/dictionary.txt")
word_chainer.run("duck", "ruby")


