require 'rubygems'
require 'bundler/setup'
require 'active_record'
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "soundcloud",  
:user => "root",
:password => "pass",
:logger => false
)
require 'soundcloud'
require 'logger'  
require 'sc_client'
require 'user'
require 'track'
require 'comment'
require 'favorite'
require 'relationship'
require 'visited'
require 'crawl'
require 'vector'
require 'corpu'
require 'stopwords'
require 'uservector'
require 'favoritevector'
require 'commentvector'
require 'preprocess'
