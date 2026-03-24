import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";

export function useCreateIssue(){
    const queryClient = useQueryClient();

    return useMutation({
        mutationFn: async (formData) =>{
            const res = await fetch(
              "http://localhost:5000/api/issue/createIssue",
              {
                method: "POST",
                headers: {
                  authorization: "Bearer " + localStorage.getItem("token"),
                },
                body: formData,
              },
            );
            if(!res.ok){
                throw new Error("Failed to create issue")
            }
            return res.json();
        },
        onSuccess:()=>{
            queryClient.invalidateQueries({ queryKey: ["issue"] });
        }
    })
}

export function useGetIssue(){
    return useQuery({
        queryFn: async () => {
            const res = await fetch(
              "http://localhost:5000/api/issue/getIssues",
              {
                method: "GET",
                headers: {
                  "Content-Type": "application/json",
                  authorization: "Bearer " + localStorage.getItem("token"),
                },
              },
            );
            if(!res.ok) {
                throw new Error("Failed to fetch issue")
            }

            return res.json()
        },
        queryKey:["issue"]
    })
}

export function useGetYourIssue(){
    return useQuery({
        queryFn: async () => {
            const res = await fetch(
              "http://localhost:5000/api/issue/students/issues",
              {
                method: "GET",
                headers: {
                  "Content-Type": "application/json",
                  authorization: "Bearer " + localStorage.getItem("token"),
                },
              },
            );
            if(!res.ok) {
                throw new Error("Failed to fetch issue")
            }

            return res.json()
        },
        queryKey:["issue"]
    })
}

export function useDeleteIssue(){
    const queryClient = useQueryClient();
    return useMutation({
        mutationFn: async (id) => {
            const res = await fetch(
              `http://localhost:5000/api/issue/deleteIssue/${id}`,
              {
                method: "DELETE",
                headers: {
                  "Content-Type": "application/json",
                  authorization: "Bearer " + localStorage.getItem("token"),
                },
              },
            );
            if(!res.ok){
                throw new Error("Failed to delete issue")
            }
            return res.json();
        },
        onSuccess: () => {
            queryClient.invalidateQueries({ queryKey: ["issue"] });
        },
    })
}

export function useUpvotes(){
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id) => {
      const res = await fetch(`http://localhost:5000/api/issue/${id}/upvotes`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          authorization: "Bearer " + localStorage.getItem("token"),
        },
      });
      if (!res.ok) {
        throw new Error("Failed to upvote issue");
      }
      return res.json();
    },
/*************  ✨ Windsurf Command ⭐  *************/
/**
 * Invalidate the query with the key "issue" after a successful upvote operation.
 */
/*******  ef1326e3-3fd8-4402-8a45-2b9475301b1d  *******/
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["issue"] });
    },
  });
}

export function useDownvotes(){
   const queryClient = useQueryClient();
  return useMutation({
    mutationFn: async (id) => {
      const res = await fetch(
        `http://localhost:5000/api/issue/${id}/downvotes`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            authorization: "Bearer " + localStorage.getItem("token"),
          },
        },
      );
      if (!res.ok) {
        throw new Error("Failed to downvote issue");
      }
      return res.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["issue"] });
    },
  });
}

