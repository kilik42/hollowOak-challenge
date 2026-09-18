FROM ubuntu:22.04

# Install the Linux tools students need
RUN apt-get update && apt-get install -y \
    vim \
    curl \
    grep \
    findutils \
    diffutils \
    coreutils \
    && rm -rf /var/lib/apt/lists/*

# Create the student account
RUN useradd -m -s /bin/bash student

# Create the investigation directory
RUN mkdir -p /home/student/hollowoak-case

# Copy the Hollow Oak case into the image
COPY hollowoak-case/ /home/student/hollowoak-case/

# Give the student ownership of the investigation
RUN chown -R student:student /home/student/hollowoak-case

# Set the investigation permissions
RUN chmod 755 /home/student/hollowoak-case \
    && chmod 644 /home/student/hollowoak-case/README.txt \
    && chmod 644 /home/student/hollowoak-case/activity_log.txt \
    && chmod 755 /home/student/hollowoak-case/records \
    && chmod 644 /home/student/hollowoak-case/records/draft-will-v1.txt \
    && chmod 444 /home/student/hollowoak-case/records/official-will.txt \
    && chmod 000 /home/student/hollowoak-case/sealed \
    && chmod 600 /home/student/hollowoak-case/sealed/codicil.txt \
    && chmod 755 /home/student/hollowoak-case/verify-record.sh

# Students enter the lab as the student user
USER student

# Start directly inside the investigation
WORKDIR /home/student/hollowoak-case

CMD ["/bin/bash"]
