module RequestsHelper
  def apply_counts(lyric)
    c = lyric.requests.count
    return c
  end
end
