# compile-to-s3
Script that pulls a repo, compiles, compresses, and uploads to S3

Set environment variables before you run, replace these with your own:

   export AWS_BUCKET=bucket \
     && export S3KEY=adfkjdlakj \
     && export S3SECRET=fjkdaljflda+fdlkaj \
     && export S3REGION=us-west-2

TODO

- improve README
- Don't hardcode repo that project is pulled from.
- improve test to me a more generic demonstration
- actually compile something for example
