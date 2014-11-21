# We need this so Fog will handle SSL for S3 buckets with dots in them.
Fog.credentials = { path_style: true }
