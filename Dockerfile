FROM python:3.6

RUN pip install transformers && \
    pip install --upgrade tensorflow

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY generate_transformers.py generate_transformers.py

CMD ["python", \
    "generate_transformers.py", \
    "--model_type=gpt2", \
    "--model_name_or_path=sberbank-ai/rugpt3large_based_on_gpt2", \
    "--k=5", \
    "--p=0.95", \
    "--length=100", \
    "--no_cuda", \
    "--prompt=Мы становимся свидетелями того, как космические корабли бороздят большой театр" \
]