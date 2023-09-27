# Use the gvenzl/oracle-xe:slim base image
FROM gvenzl/oracle-xe:slim

# Set environment variable for Oracle password
ENV ORACLE_PASSWORD=Oraxe23

# Expose the default Oracle XE listener port
EXPOSE 1521

# Create a volume for Oracle data
VOLUME ["/opt/oracle/oradata"]

# Start the Oracle XE service
CMD ["./oracle-xe-18c/start.sh"]
