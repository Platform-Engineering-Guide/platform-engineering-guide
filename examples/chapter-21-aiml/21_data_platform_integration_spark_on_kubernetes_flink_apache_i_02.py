# Training job reading Iceberg table at a specific snapshot for reproducibility
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .config("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions") \
    .config("spark.sql.catalog.glue", "org.apache.iceberg.spark.SparkCatalog") \
    .config("spark.sql.catalog.glue.catalog-impl", "org.apache.iceberg.aws.glue.GlueCatalog") \
    .config("spark.sql.catalog.glue.warehouse", "s3://your-data-lake/warehouse/") \
    .getOrCreate()

# Read training features as of a specific snapshot for reproducibility
# snapshot_id is stored in the model's metadata at training time
training_data = spark.read \
    .option("snapshot-id", "8954789456789234567") \
    .table("glue.features.transaction_features")
