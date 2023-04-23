start:
	@uvicorn main:app --reload


up:
	@docker-compose up -d


down:
	@docker-compose down


init:
	@python3 -m venv venv
	@source venv/bin/activate
	@pip install -r requirements.txt
	@pip freeze > requirements.txt


curl:
	@curl http://localhost:7860/generate?text=hot%20weather%20today,%20don


build: # Builds the docker image.
	@docker build -t alextanhongpin/docker-fastapi-ml .
