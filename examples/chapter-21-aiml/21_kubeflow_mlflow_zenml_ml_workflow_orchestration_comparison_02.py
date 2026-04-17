# ZenML pipeline definition — backend-agnostic
from zenml import pipeline, step
from zenml.config import DockerSettings

docker_settings = DockerSettings(required_integrations=["sklearn"])

@step
def load_data() -> tuple:
    from sklearn.datasets import load_iris
    from sklearn.model_selection import train_test_split
    X, y = load_iris(return_X_y=True)
    return train_test_split(X, y, test_size=0.2, random_state=42)

@step
def train_model(X_train, y_train) -> object:
    from sklearn.ensemble import RandomForestClassifier
    model = RandomForestClassifier(n_estimators=100)
    model.fit(X_train, y_train)
    return model

@step
def evaluate_model(model, X_test, y_test) -> float:
    return model.score(X_test, y_test)

@pipeline(settings={"docker": docker_settings})
def training_pipeline():
    X_train, X_test, y_train, y_test = load_data()
    model = train_model(X_train, y_train)
    accuracy = evaluate_model(model, X_test, y_test)
