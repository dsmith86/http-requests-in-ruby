require 'httparty'
require 'parallel'
require 'typhoeus'

class Time
	def until_now
		Time.now - self
	end
end

class Request
	def self.synchronous (count)
		time = Time.now

		count.times { HTTParty.get "http://www.example.com" }

		self.log(count, time.until_now, 'synchronous requests')
	end

	def self.threaded (count)
		time = Time.now

		threads = []

		threads << Thread.new { count.times { HTTParty.get "http://www.example.com" } }

		threads.each { |thr| thr.join }

		self.log(count, time.until_now, 'threaded requests')
	end

	def self.parallel (count)
		time = Time.now

		Parallel.each(1..count) do
			HTTParty.get "http://www.example.com"; raise Parallel::Break
		end

		self.log(count, time.until_now, 'the parallel gem')
	end

	def self.typhoeus (count)
		time = Time.now

		hydra = Typhoeus::Hydra.new

		count.times do
			request = Typhoeus::Request.new("http://www.example.com", followlocation: true)
			hydra.queue(request)
		end

		hydra.run

		self.log(count, time.until_now, 'Typhoeus and his daughter, Hydra')
	end

	def self.log (count, time, method)
		puts "downloaded #{count} files in #{time} seconds using #{method}."
	end
end

(1..10).each do |i|
	Request.synchronous(i)
	Request.threaded(i)
	Request.parallel(i)
	Request.typhoeus(i)
end
