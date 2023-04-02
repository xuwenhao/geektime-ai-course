import pytest  # used for our unit tests


def format_time(seconds):
    minutes, seconds = divmod(seconds, 60)
    hours, minutes = divmod(minutes, 60)

    if hours > 0:
        return f"{hours}h{minutes}min{seconds}s"
    elif minutes > 0:
        return f"{minutes}min{seconds}s"
    else:
        return f"{seconds}s"


#Below, each test case is represented by a tuple passed to the @pytest.mark.parametrize decorator.
#The first element of the tuple is the name of the test case, and the second element is the value to be passed to the format_time() function.
@pytest.mark.parametrize('test_input,expected', [
    ('0', '0s'),
    ('59', '59s'),
    ('60', '1min0s'),
    ('119', '1min59s'),
    ('3600', '1h0min0s'),
    ('3601', '1h0min1s'),
    ('3660', '1h1min0s'),
    ('7200', '2h0min0s'),
])
def test_format_time(test_input, expected):
    #For each test case, we call the format_time() function and compare the returned value to the expected value.
    assert format_time(int(test_input)) == expected


#We use the @pytest.mark.parametrize decorator again to test the invalid inputs.
@pytest.mark.parametrize('test_input', [
    None,
    'abc',
    -1
])
def test_format_time_invalid_inputs(test_input):
    #For each invalid input, we expect a TypeError or ValueError to be raised.
    with pytest.raises((TypeError, ValueError)):
        format_time(test_input)