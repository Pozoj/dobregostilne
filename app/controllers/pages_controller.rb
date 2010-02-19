class PagesController < ApplicationController
  skip_before_filter :authenticate
end