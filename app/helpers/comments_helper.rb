module CommentsHelper
  def comment_counts(lyric)
    c = lyric.comments.count
    return c
  end
end
