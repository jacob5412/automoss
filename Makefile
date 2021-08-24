
install:
	sudo apt-get install redis
	pip3 install -r requirements_dev.txt

run:
	python manage.py runserver

# Listen for messages from broker
listen:
	celery -A automoss worker --loglevel=info

migrations:
	python manage.py makemigrations && python manage.py migrate

delete-db:
	rm db.sqlite3

# https://simpleisbetterthancomplex.com/tutorial/2016/07/26/how-to-reset-migrations.html
db: delete-db clean migrations

clean:
	rm dump.rdb
	find . -path '*/migrations/*.py' -not -name '__init__.py' -delete

test:
	python manage.py test

coverage:
	coverage run --source='.' manage.py test && coverage report
