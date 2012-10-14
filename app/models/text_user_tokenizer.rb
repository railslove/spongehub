class TextUserTokenizer
  TOKEN_REGEXP = /@([^\W]+)/

  def initialize(text, users)
    @text = text
    @users = users
  end

  def unique_match
    return nil unless @text.match(TOKEN_REGEXP)
    match_users_and_tokens[0]
  end

  def unique_match_token
    return nil unless @text.match(TOKEN_REGEXP)
    match_users_and_tokens[1]
  end

  protected

  def match_users_and_tokens
    @match_users_and_tokens ||= begin
      results = []
      token = nil
      # Try partial matches
      hit = @text.match(TOKEN_REGEXP)
      if hit
        token = hit[1]
        results = @users.select{ |user| user.name.match(/\b#{hit[1]}/i) }
      end

      # Try exact matching
      if results.size > 1
        results = @users.select{ |user| user.name.match(/\b#{hit[1]}\b/i) }
      end

      # Try two words (first and last name)
      if results.size > 1
        if hit = @text.match(/@([^\W]+\s(\w+))/)
          token = hit[1]
          results = @users.select{ |user| user.name.match(/\b#{hit[1]}\b/i) }
        end
      end

      # return first item or just nil
      [results.first, token]
    end
  end
end