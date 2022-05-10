module Drops
  class BreadcrumbItem < Liquid::Drop
    extend Forwardable

    def_delegator :@page, :data
    def_delegator :@page, :url

    def initialize(page, payload)
      @payload = payload
      @page = page
    end

    def title
	  @page.data['short-title'] || @page.data['crumbtitle'] || @page.data['title']
    end

    def subset
      @page.data['subset']
    end
  end
end

Jekyll::Hooks.register :pages, :pre_render do |page, payload|
  if page.url == '/'
    then payload['breadcrumbs'] = [
      Drops::BreadcrumbItem.new(page, payload)
    ]
  else
    payload['breadcrumbs'] = []
    pth = page.url.split('/')

    0.upto(pth.size - 1) do |int|
      joined_path = pth[0..int].join('/')
      item = page.site.pages.find { |page_| joined_path == '' && page_.url == '/' || page_.url.chomp('/') == joined_path }
      payload['breadcrumbs'] << Drops::BreadcrumbItem.new(item, payload) if item
    end
  end
end

Jekyll::Hooks.register :documents, :pre_render do |documents, payload|
  if documents.url == '/'
    then payload['breadcrumbs'] = [
      Drops::BreadcrumbItem.new(documents, payload)
    ]
  else
    payload['breadcrumbs'] = []
    pth = documents.url.split('/')

    0.upto(pth.size - 1) do |int|
      joined_path = pth[0..int].join('/')
      item = documents.site.documents.find { |document_| joined_path == '' && document_.url == '/' || document_.url.chomp('/') == joined_path }
      payload['breadcrumbs'] << Drops::BreadcrumbItem.new(item, payload) if item
    end
  end
end
