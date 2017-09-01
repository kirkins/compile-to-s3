# compile-to-s3
Script that pulls a repo, compiles, compresses, and uploads to S3

Note: id_rsa is a private key made specifically for a private repo. You can replace it with your own for a private repo or just use a public repo.

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
