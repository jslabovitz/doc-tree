require 'test/unit'
require 'pp'
require 'wrong'

$LOAD_PATH.unshift 'lib'

require 'doc-tree'

class Thing < DocTree::Document
  
end

class TreeTest < Test::Unit::TestCase
  
  include Wrong

  def setup
    @tree = DocTree::Tree.new('test/content',
      :classes => {
        '/things' => Thing,
      }
    )
  end
  
  def test_doc_exists
    doc = @tree['/main1']
    assert { doc }
    assert { doc.title == 'The main page' }
  end
  
  def test_doc_exists_with_dir
    doc = @tree['/main2']
    assert { doc }
    assert { doc.title == 'Another page' }
  end
  
  def test_subdoc_exists
    doc = @tree['/main2/foo']
    assert { doc }
    assert { doc.title == 'Foo' }
  end
  
  def test_index_doc
    doc = @tree['/section1']
    assert { doc }
    assert { doc.title == 'Section 1' }
    assert { doc.path == '/section1' }
  end
  
  def test_section_has_correct_index_doc
    doc = @tree['/section1/sub1a']
    assert { doc.index_doc.path == '/section1' }
  end
  
  def test_doc_has_more_docs
    doc = @tree['/section1/sub1a']
    more_docs_paths = ['/section1', '/section1/sub1b']
    assert { doc.more_docs.map(&:path) == more_docs_paths }
  end
  
  def test_doc_has_other_index_docs
    doc = @tree['/section1/sub1a']
    other_index_docs_paths = ['/', '/main2', '/section2']
    assert { doc.other_index_docs.map(&:path) == other_index_docs_paths }
  end
  
  def test_custom_classes
    paths = %w{/things/thing1 /things/thing2}
    paths.each do |path|
      doc = @tree[path]
      assert { doc.kind_of?(Thing) }
    end
    things = @tree.select(:class => Thing)
    assert { !things.empty? }
    assert { things.map(&:path) == paths }
    things = @tree.select { |doc| doc.title == 'Thing 1' }
    assert { things.first == @tree['/things/thing1'] }
  end
  
  def test_to_html
    doc = @tree['/main1']
    html = Nokogiri(doc.to_html)
    assert { html.at_xpath('//title').text == 'The main page' }
  end
  
end