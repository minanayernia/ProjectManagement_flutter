import back.models as models
import rest_framework.serializers as serializers

class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Person
        fields = '__all__'

class BoardSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Board
        fields = '__all__'

class HoldingSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Holding
        fields = '__all__'

class BoardListSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.BoardList
        fields = '__all__'

class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Task
        fields = '__all__'

class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Comment
        fields = '__all__'