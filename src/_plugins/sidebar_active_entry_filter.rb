module ActiveNavEntriesFilter
  def active_nav_entry_index_array(nav_entry_tree, page_url_path = '')
    active_entry_indices = _get_active_nav_entries(nav_entry_tree, page_url_path)
    active_entry_indices.empty? ? nil : active_entry_indices
    page_url_path
  end

  def _get_active_nav_entries(nav_entry_tree, page_url_path = '')
    nav_entry_tree.each_with_index do |entry, i|
      if entry['children']
        descendant_indices = _get_active_nav_entries(entry['children'], page_url_path)
        return [i + 1] + descendant_indices unless descendant_indices.empty?
      end

      next unless entry['permalink']

      return [i + 1] if page_url_path.include? entry['permalink']
    end
    []
  end
end

Liquid::Template.register_filter(ActiveNavEntriesFilter)
