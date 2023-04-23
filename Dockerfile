FROM python:3.11


WORKDIR /code
COPY ./requirements.txt /code/requirements.txt

# Install the packages listed in requirements.txt.
# --no-cache-dir: tells pip not to use any cached packages
# --upgrade: tells pip to upgrade any already-installed packages if newer versions are available.
# -r: specifies the requirements file to use.
RUN pip install -r /code/requirements.txt

# Creates a new user named 'user' with a user ID of 1000, switch to that user,
# and then set the home directory to /home/user.
# Path is modified to include the `.local/bin` directory in the user's home
# directory so that any binaries installed by pip will be available on the
# command line.
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
		PATH=/home/user/.local/bin:$PATH

# Sets the working directory inside the container to `$HOME/app`, which is `/home/user/app`.
WORKDIR $HOME/app

# Copies the contents our local directory into the /home/user/app directory
# inside the container, setting the owner of the files to that user that we
# created earlier.
COPY --chown=user . $HOME/app

# Starts the FastAPI app using `uvicorn` and listens on port 7860.
# --host: tells the app to listen on all available network interfaces.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]
