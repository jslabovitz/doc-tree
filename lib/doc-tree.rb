# system
require 'pp'
require 'pathname'
require 'fileutils'

# gems
require 'tree'
require 'RedCloth'
require 'hashstruct'

# local
require 'rack/doc-tree'

module Tree
  
  class TreeNode
    
    def print_tree2(level=0, &block)
      if is_root?
        print '*'
      else
        print "\t" * level
      end
      print " #{name.inspect}"
      print " (#{children.length} children)" if has_children?
      if block_given?
        text = yield(self)
        print " [#{text}]" if text
      end
      puts
      children { |child| child.print_tree2(level + 1, &block)}
    end
    
    def path
      ([self] + (parentage || [nil])).map { |n| n && n.name }.reverse.join('/')
    end
    
  end
  
end

module DocTree
    
  class Tree
  
    attr_accessor :root
  
    def initialize(root_path, options={})
      root_path = Pathname.new(root_path)
      @root = ::Tree::TreeNode.new('')
      FileUtils.chdir(root_path) do
        Pathname.new('.').find do |file_path|
          if file_path.file? && file_path.extname == '.textile'
            components = file_path.each_filename.to_a
            doc_name = components.pop.sub(/#{Regexp.quote(file_path.extname)}$/, '')
            parent = @root
            components.each do |name|
              parent = parent[name] || (parent << ::Tree::TreeNode.new(name))
            end
            raise "Can't find parent for #{file_path}" unless parent
            if doc_name == 'index'
              node = parent
            elsif (node = parent[doc_name]).nil?
              node = ::Tree::TreeNode.new(doc_name, nil)
              parent << node
            end
            if (classes = options[:classes])
              path = node.path
              prefix, doc_class = classes.find { |prefix, klass| path =~ /^#{Regexp.quote(prefix)}/ }
            end
            doc_class ||= options[:default_class] || Document
            node.content = doc_class.new(file_path, node)
          end
        end
      end
    end
    
    def docs
      @root.map { |n| n.content }.compact
    end
    
    def latest
      docs.reject { |d| d.date.nil? }.sort.last
    end
    
    def doc_at_path(path)
      path = Pathname.new(path)
      node = @root
      path.each_filename do |name|
        node = node[name] or break
      end
      # ;;warn "doc_at_path(#{path.inspect}) => #{node.name.inspect}"
      node.content if node && node.content
    end
  
    def [](path)
      doc_at_path(path)
    end
    
    def print
      @root.print_tree2 do |node|
        if (doc = node.content)
          "#{doc.title.inspect} @ #{doc.path}"
        end
      end
    end
    
  end
  
  class Document
  
    attr_accessor :header
    attr_accessor :text
    attr_accessor :node
    
    def initialize(file_path, node)
      file_path = Pathname.new(file_path)
      @header = HashStruct.new
      file_path.open do |fh|
        while (line = fh.readline.chomp) != '' && line =~ /^([A-Za-z\-]+):\s+(.*)/
          key, value = $1, $2
          key = key.gsub('-', '_').downcase.to_sym
          @header[key] = value
        end
        @text = RedCloth.new(fh.read.strip)
      end
      @header.mtime = file_path.mtime.to_datetime
      # @header.date ||= @header.mtime
      @node = node
    end
  
    def inspect
      "<#{self.class} header=#{@header.inspect}, text=#{(@text ? (@text[0..20] + '...') : nil).inspect}>"
    end
    
    def <=>(other)
      self.date <=> other.date
    end

    def to_html
      @text.to_html
    end
      
    def title
      @header.title
    end
    
    def mtime
      @header.mtime
    end
    
    def date
      @header.date
    end
    
    def path
      @node.path
    end
    
    def index_doc
      @node.parent.content unless @node.is_root?
    end
    
    def more_docs
      ([@node.parent] + @node.siblings - [@node]).map(&:content)
    end
    
    def all_index_docs
      @node.root.select { |n| n.has_children? }.map(&:content)
    end
    
    def other_index_docs
      (all_index_docs - [index_doc])
    end
  
  end
  
end