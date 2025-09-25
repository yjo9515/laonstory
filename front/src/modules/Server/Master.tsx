import { useMutation, useQuery, useQueryClient } from "react-query";

export function OtherViewModule() {
  const { data, error, isFetching } = useQuery(["todos"], () => console.log(), {
    refetchOnWindowFocus: false,
    retry: 0,
    onSuccess: (data) => {},
    onError: (data) => {},
  });

  return {
    res: {
      data,
      error,
      isFetching,
    },
  };
}
